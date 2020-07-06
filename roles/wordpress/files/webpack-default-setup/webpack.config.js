const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const StylelintPlugin = require('stylelint-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

const themePath = './wp-content/themes/custom-theme';

let config = {
  entry: {
    bundle: themePath + '/src/js/app.js',
  },
  output: {
    path: path.resolve(__dirname, themePath + '/assets/'),
    filename: 'js/[name].js',
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
          },
          {
            loader: 'eslint-loader',
          },
        ],
      },
      {
        test: /\.scss$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
          },
          {
            loader: 'css-loader',
            options: {
              sourceMap: true,
            },
          },
          {
            loader: 'postcss-loader',
            options: {
              plugins: () => [require('autoprefixer')],
              sourceMap: true,
            },
          },
          {
            loader: 'sass-loader',
          },
        ],
      },
      {
        test: /\.woff2?$|\.ttf$|\.otf$|\.eot$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              outputPath: 'font/',
              publicPath: '../font/',
            },
          },
        ],
      },
      {
        test: /\.png?$|\.jpg$|\.svg$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              outputPath: 'images/',
              publicPath: '../images/',
            },
          },
        ],
      },
    ],
  },
  plugins: [
    new CleanWebpackPlugin(),
    new MiniCssExtractPlugin({
      filename: 'css/[name].css',
      chunkFilename: 'css/[id].css',
    }),
    new CopyWebpackPlugin([
      { from: themePath + '/src/images/', to: '../assets/images/' },
      { from: themePath + '/src/favicon/', to: '../assets/favicon/' },
    ]),
    new StylelintPlugin(),
  ],
  externals: {
    jquery: 'jQuery',
  },
};

module.exports = (env, argv) => {
  if (argv.mode === 'development') {
    config.devtool = 'source-map';
  }
  return config;
};
