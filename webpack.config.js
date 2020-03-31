const path = require("path");
module.exports = {
  entry: "./src/app.coffee",
  mode: "development",
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: ["coffee-loader"]
      },
      {
        test: /\.s[ac]ss$/i,
        use: ["style-loader", "css-loader", "sass-loader"]
      }
    ]
  },
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "app.js"
  },
  devServer: {
    contentBase: path.join(__dirname, "src"),
    compress: true,
    port: 3000
  }
};
