import java.util.*;

class AnagramFinder {
    public static List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();
        if (s.length() < p.length()) return result;

        int[] pCount = new int[26];
        int[] sCount = new int[26];

        for (char c : p.toCharArray()) pCount[c - 'a']++;

        for (int i = 0; i < s.length(); i++) {
            sCount[s.charAt(i) - 'a']++;

            if (i >= p.length()) sCount[s.charAt(i - p.length()) - 'a']--;

            if (Arrays.equals(sCount, pCount)) result.add(i - p.length() + 1);
        }
        return result;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter main string (s): ");
        String s = scanner.nextLine();

        System.out.print("Enter pattern string (p): ");
        String p = scanner.nextLine();

        System.out.println("Anagram indices: " + findAnagrams(s, p));
        scanner.close();
    }
}