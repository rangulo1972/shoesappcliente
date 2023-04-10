class Calculate {
  static double getPrice(double price, int discount) {
    if (discount > 0) {
      price = price - (price * discount / 100);
    }
    return price;
  }
}
