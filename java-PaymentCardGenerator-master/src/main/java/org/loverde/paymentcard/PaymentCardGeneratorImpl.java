/*
 * PaymentCardGenerator
 * https://www.github.com/kloverde/java-PaymentCardGenerator
 *
 * Copyright (c) 2016 Kurtis LoVerde
 * All rights reserved
 *
 * Donations:  https://paypal.me/KurtisLoVerde/5
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     1. Redistributions of source code must retain the above copyright
 *        notice, this list of conditions and the following disclaimer.
 *     2. Redistributions in binary form must reproduce the above copyright
 *        notice, this list of conditions and the following disclaimer in the
 *        documentation and/or other materials provided with the distribution.
 *     3. Neither the name of the copyright holder nor the names of its
 *        contributors may be used to endorse or promote products derived from
 *        this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package org.loverde.paymentcard;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import static org.loverde.paymentcard.internal.Objects.failIf;
import static org.loverde.paymentcard.internal.Objects.randomItemFromSet;


/**
 * <p>
 * This software aids in testing payment card processing systems by generating random payment card
 * numbers which are mathematically valid, so that you don't have to use an actual card.
 * <p>
 * This class generates payment card numbers based on the criteria defined here:
 * </p>
 *
 * <ul>
 *    <li><a href="https://en.wikipedia.org/wiki/Luhn_algorithm">https://en.wikipedia.org/wiki/Luhn_algorithm</a></li>
 *    <li><a href="https://en.wikipedia.org/wiki/Payment_card_number">https://en.wikipedia.org/wiki/Payment_card_number</a> (as of April 2024)</li>
 * </ul>
 *
 * <p>
 *    Most if not all of the payment card numbers generated by this software should not be tied to active
 *    accounts.  However, it is theoretically possible that, against all odds, this software could randomly
 *    generate a payment card number that's in use in the real world.  For this reason, you must ensure
 *    that these card numbers are only used in systems running in test mode, i.e. that a real transaction
 *    will not be attempted.
 * </p>
 *
 * <p>
 *    There's no point in trying to use this software for fraudulent purposes.  Not only will card numbers
 *    generated by this software likely not work, but if this software were by coincidence to generate an
 *    actual active account number, it would be illegal for you to attempt to use it.  Of course, you're
 *    smart enough to know this already.  You alone are responsible for what you do with this software.
 * </p>
 */
public class PaymentCardGeneratorImpl implements PaymentCardGenerator {

    @Override
    public String generateByCardType(final CardType cardType) {
        failIf(cardType == null, () -> "Card type is null");
        return generateCardNumber(cardType);
    }

    @Override
    public List<String> generateListByCardType(final int howMany, final CardType cardType) {
        failIf(howMany <= 0, () -> "How many must be greater than zero");
        failIf(cardType == null, () -> "Card type is null");

        return IntStream.range(0, howMany).mapToObj(i -> generateCardNumber(cardType)).collect(Collectors.toList());
    }

    @Override
    public Map<CardType, List<String>> generateMapByCardTypes(final int howManyOfEach, final CardType... cardTypes) {
        failIf(howManyOfEach <= 0, () -> "How many of each must be greater than zero");
        failIf(cardTypes == null || cardTypes.length < 1, () -> "Card types is null or empty");

        final Map<CardType, List<String>> cardNums = new HashMap<>(cardTypes.length);

        removeVarargDuplicates(cardTypes).forEach(cardType -> cardNums.put(cardType, generateListByCardType(howManyOfEach, cardType)));

        return cardNums;
    }

    @Override
    public Map<Long, List<String>> generateByPrefix(final int howManyOfEachPrefix, final Set<Integer> lengths, final Set<Long> prefixes) {
        failIf(howManyOfEachPrefix <= 0, () -> "How many of each must be greater than zero");
        failIf(lengths == null || lengths.isEmpty(), () -> "No lengths were specified");
        failIf(prefixes == null || prefixes.isEmpty(), () -> "No prefixes were specified");

        for (final Integer length : lengths) {
            failIf(length == null || length < 2, () -> "Invalid length: " + length);

            for (final Long prefix : prefixes) {
                failIf(prefix.toString().length() > length, () -> "Prefix (%s) is longer than length (%d)".formatted(prefix.toString(), length));
                failIf(prefix < 1, () -> "Prefix (%s):  prefixes must be positive numbers".formatted(prefix.toString()));
            }
        }

        final Map<Long, List<String>> cardNums = new HashMap<>(prefixes.size());

        for (final Long prefix : prefixes) {
            final List<String> cardNumsForPrefix = new ArrayList<>(howManyOfEachPrefix);

            for (int i = 0; i < howManyOfEachPrefix; i++) {
                cardNumsForPrefix.add(generateCardNumber(prefix, randomItemFromSet(lengths)));
            }

            cardNums.put(prefix, cardNumsForPrefix);
        }

        return cardNums;
    }

    @Override
    public boolean passesLuhnCheck(final String num) {
        failIf(num == null || num.isEmpty(), () -> "Number is null or empty");

        final int sum = calculateLuhnSum(num, true);
        final int checkDigit = calculateCheckDigit(sum);

        return (sum + checkDigit) % 10 == 0 && Integer.parseInt(num.substring(num.length() - 1)) == checkDigit;
    }

    private static String generateCardNumber(final CardType cardType) {
        return generateCardNumber(
            randomItemFromSet(cardType.getPrefixes()),
            randomItemFromSet(cardType.getLengths()));
    }

    private static String generateCardNumber(final Long prefix, final int length) {
        final StringBuilder num = new StringBuilder(prefix.toString());

        final int howManyMore = length - num.toString().length() - 1;
        final Random random = ThreadLocalRandom.current();

        for (int i = 0; i < howManyMore; i++) {
            num.append(Integer.valueOf(random.nextInt(9)));
        }

        num.append(calculateCheckDigit(num.toString()));

        return num.toString();
    }

    private static int calculateCheckDigit(final String str) {
        final int sum = calculateLuhnSum(str, false);
        return calculateCheckDigit(sum);
    }

    private static int calculateCheckDigit(final int luhnSum) {
        return (luhnSum * 9) % 10;
    }

    private static int calculateLuhnSum(final String str, final boolean hasCheckDigit) {
        final int[] luhnNums = new int[str.length()];
        final int start = str.length() - (hasCheckDigit ? 2 : 1);
        int sum = 0;

        boolean doubleMe = true;

        for (int i = start; i >= 0; i--) {
            final int num = Integer.parseInt(str.substring(i, i + 1));

            if (doubleMe) {
                int x2 = num * 2;
                luhnNums[i] = x2 > 9 ? x2 - 9 : x2;
            } else {
                luhnNums[i] = num;
            }

            sum += luhnNums[i];
            doubleMe = !doubleMe;
        }

        return sum;
    }

    @SafeVarargs
    private static <T> Set<T> removeVarargDuplicates(final T... stuff) {
        return Stream.ofNullable(stuff)
            .flatMap(Arrays::stream)
            .filter(Objects::nonNull)
            .collect(Collectors.toSet());
    }
}