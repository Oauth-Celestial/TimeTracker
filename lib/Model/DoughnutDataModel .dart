class DoughnutData {
  DoughnutData(this.x, this.y);

  final String x;
  final double y;

  Map<String, dynamic> toJson() {
    return {'domain': this.x, 'measure': this.y};
  }
}
