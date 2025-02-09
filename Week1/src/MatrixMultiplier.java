import java.util.Scanner;

class MatrixMultiplier {
    private static int[][] result;

    public static void multiplyMatrices(int[][] A, int[][] B, int numRows) {
        int rowsA = A.length, colsA = A[0].length, colsB = B[0].length;
        result = new int[rowsA][colsB];

        Thread[] threads = new Thread[numRows];

        for (int i = 0; i < numRows; i++) {
            final int row = i;
            threads[i] = new Thread(() -> {
                for (int j = 0; j < colsB; j++) {
                    for (int k = 0; k < colsA; k++) result[row][j] += A[row][k] * B[k][j];
                }
            });
            threads[i].start();
        }

        for (Thread thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter rows and columns of matrix A: ");
        int rowsA = scanner.nextInt(), colsA = scanner.nextInt();
        int[][] A = new int[rowsA][colsA];

        System.out.println("Enter elements of matrix A:");
        for (int i = 0; i < rowsA; i++) for (int j = 0; j < colsA; j++) A[i][j] = scanner.nextInt();

        System.out.print("Enter columns of matrix B (rows must be " + colsA + "): ");
        int colsB = scanner.nextInt();
        int[][] B = new int[colsA][colsB];

        System.out.println("Enter elements of matrix B:");
        for (int i = 0; i < colsA; i++) for (int j = 0; j < colsB; j++) B[i][j] = scanner.nextInt();

        multiplyMatrices(A, B, rowsA);

        System.out.println("Resultant Matrix:");
        for (int[] row : result) {
            for (int val : row) System.out.print(val + " ");
            System.out.println();
        }

        scanner.close();
    }
}