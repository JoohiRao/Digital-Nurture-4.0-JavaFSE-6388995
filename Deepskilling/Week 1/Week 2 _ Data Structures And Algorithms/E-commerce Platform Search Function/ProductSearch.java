class ProductSearch {
    public static Product search(Product[] products, String name) {
        // Step 1: Sort products by name (case-insensitive)
        Arrays.sort(products, (p1, p2) -> p1.productName.compareToIgnoreCase(p2.productName));

        // Step 2: Perform binary search
        int low = 0;
        int high = products.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            int result = products[mid].productName.compareToIgnoreCase(name);

            if (result == 0) {
                return products[mid]; // match found
            } else if (result < 0) {
                low = mid + 1; // search right half
            } else {
                high = mid - 1; // search left half
            }
        }

        return null; // not found
    }
}

// Non-public class in the same file
class LinearSearch {
    public static Product search(Product[] products, String name) {
        for (Product p : products) {
            if (p.productName.equalsIgnoreCase(name)) {
                return p;
            }
        }
        return null;
    }
}
