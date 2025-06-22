import java.util.Scanner;

public class FinancialForecast {

    // Recursive method to calculate future value
    public static double calculateFutureValue(double initialAmount, double annualGrowthRate, int totalYears) {
        if (totalYears == 0) {
            return initialAmount; // base case
        }
        return (1 + annualGrowthRate) * calculateFutureValue(initialAmount, annualGrowthRate, totalYears - 1);
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Input: Initial investment amount
        System.out.print("Enter the initial investment amount (₹): ");
        double initialAmount = scanner.nextDouble();

        // Input: Annual growth rate
        System.out.print("Enter the expected annual growth rate (%): ");
        double growthRatePercent = scanner.nextDouble();
        double annualGrowthRate = growthRatePercent / 100.0;

        // Input: Number of years to forecast
        System.out.print("Enter the number of years to forecast: ");
        int totalYears = scanner.nextInt();

        // Calculate future value using recursion
        double predictedAmount = calculateFutureValue(initialAmount, annualGrowthRate, totalYears);

        // Output
        System.out.printf("Predicted amount after %d years: ₹%.2f\n", totalYears, predictedAmount);

        scanner.close();
    }
}
