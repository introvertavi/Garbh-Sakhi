package com.garbhsakhi.util;

import java.time.LocalDate;
import java.time.Period;

public class PregnancyUtil {

    public static int getPregnancyWeek(String dueDateStr) {
        if (dueDateStr == null || dueDateStr.isEmpty()) return 0;

        LocalDate dueDate = LocalDate.parse(dueDateStr);
        LocalDate today = LocalDate.now();

        // Pregnancy is 40 weeks total
        LocalDate conceptionDate = dueDate.minusWeeks(40);

        Period diff = Period.between(conceptionDate, today);

        int weeks = diff.getDays() / 7 + diff.getMonths() * 4 + diff.getYears() * 52;
        return Math.max(1, Math.min(weeks, 40)); // clamp 1 to 40
    }

    public static String getFruitForWeek(int week) {
        if (week < 1 || week > 40) return "🌱 Unknown";

        String[] fruits = {
                "Poppy Seed", "Apple Seed", "Blueberry", "Lemon", "Peach", "Plum", "Avocado",
                "Orange", "Mango", "Banana", "Papaya", "Grapefruit", "Pineapple", "Coconut"
        };

        return fruits[Math.min(week / 3, fruits.length - 1)];
    }
}