public class SearchTest {
    public static void main(String[] args) {
        Product[] products = {
                new Product(1, "TV", "Electronics"),
                new Product(2, "iPhone", "Electronics"),
                new Product(3, "Nike Shoes", "Fashion"),
                new Product(4, "Washing Machine", "Electronics"),
                new Product(5, "Jeans", "Fashion")
        };

        System.out.println("Linear Search:");
        Product p1 = ProductSearch.search(products, "MacBook");
        if (p1 != null) p1.printDetails();
        else System.out.println("Product not found");

        System.out.println("\nBinary Search:");
        Product p2 = BinarySearch.search(products, "MacBook");
        if (p2 != null) p2.printDetails();
        else System.out.println("Product not found");
    }
}
