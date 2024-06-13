const webpack = require("webpack");
const rimraf = require("rimraf");
const webpackConfig = require("../webpack/webpack.prod");

const { compilerListener, paths, compilation } = require("./utils");

const build = async () => {
  try {
    rimraf.sync(paths.build);

    const compiler = webpack(webpackConfig);

    compiler.run((err, stats) => compilation(err, stats, compiler.stats));

    await compilerListener(compiler);

    console.log("Compilação do Webpack no cliente e no servidor concluída!");
  } catch (error) {
    console.error(error);
  }
};

build();
