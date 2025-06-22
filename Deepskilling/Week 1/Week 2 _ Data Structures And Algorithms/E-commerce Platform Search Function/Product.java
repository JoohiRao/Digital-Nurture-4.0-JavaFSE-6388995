class Product {
    int productId;
    String productName;
    String category;

    Product(int id, String name, String category) {
        this.productId = id;
        this.productName = name;
        this.category = category;
    }

    public void printDetails() {
        System.out.println("ID: " + productId + ", Name: " + productName + ", Category: " + category);
    }
}
