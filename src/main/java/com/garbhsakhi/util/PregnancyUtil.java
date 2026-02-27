package com.garbhsakhi.util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class PregnancyUtil {

    // ===============================
    // CALCULATE CURRENT PREGNANCY WEEK
    // ===============================
    public static int getPregnancyWeek(String dueDateStr) {

        if (dueDateStr == null || dueDateStr.isBlank())
            return 0;

        LocalDate dueDate = LocalDate.parse(dueDateStr);
        LocalDate today = LocalDate.now();

        // Pregnancy duration = 40 weeks
        LocalDate conceptionDate = dueDate.minusWeeks(40);

        long daysPregnant =
                ChronoUnit.DAYS.between(conceptionDate, today);

        int weeks = (int) (daysPregnant / 7);

        // Clamp between 1 and 40
        return Math.max(1, Math.min(weeks, 40));
    }


    // ===============================
    // BABY SIZE (FRUIT REPRESENTATION)
    // ===============================
    public static String getFruitForWeek(int week) {

        if (week < 1 || week > 40)
            return "🌱 Unknown";

        String[] fruits = {
                "Poppy Seed", "Apple Seed", "Blueberry", "Lemon",
                "Peach", "Plum", "Avocado", "Orange",
                "Mango", "Banana", "Papaya", "Grapefruit",
                "Pineapple", "Coconut"
        };

        return fruits[Math.min(week / 3, fruits.length - 1)];
    }


    // ==========================================
    // DAILY HEALTH TIP (CHANGES EVERY DAY)
    // ==========================================
    public static String getDailyHealthTip(int week) {

        if (week <= 0) {
            return "Maintain a healthy routine and stay positive.";
        }

        String[] tips;

        // FIRST TRIMESTER
        if (week <= 12) {
            tips = new String[]{
                    "Eat small frequent meals to reduce nausea.",
                    "Stay hydrated throughout the day.",
                    "Take prenatal vitamins regularly.",
                    "Rest whenever your body feels tired.",
                    "Avoid strong smells that trigger nausea.",
                    "Include folic acid rich foods daily.",
                    "Light walking can improve energy levels."
            };
        }

        // SECOND TRIMESTER
        else if (week <= 28) {
            tips = new String[]{
                    "Maintain gentle daily exercise.",
                    "Practice good sitting posture.",
                    "Increase iron-rich foods like spinach.",
                    "Sleep on your left side for better circulation.",
                    "Stretch lightly to reduce back pain.",
                    "Drink enough fluids during the day.",
                    "Monitor weight gain gradually and healthily."
            };
        }

        // THIRD TRIMESTER
        else {
            tips = new String[]{
                    "Track baby movements daily.",
                    "Prepare hospital essentials slowly.",
                    "Practice breathing exercises.",
                    "Avoid standing for long durations.",
                    "Keep emergency contacts ready.",
                    "Prioritize sleep and relaxation.",
                    "Attend all scheduled medical checkups."
            };
        }

        // DAILY ROTATION LOGIC
        int daySeed = LocalDate.now().getDayOfYear();

        int index = Math.abs((week + daySeed) % tips.length);

        return tips[index];
    }
}