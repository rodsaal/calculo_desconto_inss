import path from 'path';
import { fileURLToPath } from 'url';
import esbuild from 'esbuild';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const config = {
  entryPoints: ['application.js'],
  bundle: true,
  outdir: path.join(__dirname, 'app/assets/builds'),
  absWorkingDir: path.join(__dirname, 'app/javascript'),
  publicPath: '/assets',
  sourcemap: true,
  loader: {
    '.js': 'jsx',
    '.png': 'file',
    '.svg': 'file'
  },
  define: {
    'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV || 'development')
  }
};

// Modo desenvolvimento simplificado (sem serve)
if (process.env.NODE_ENV === 'production') {
  esbuild.build({
    ...config,
    minify: true,
    target: ['es2015']
  }).catch(() => process.exit(1));
} else {
  const ctx = await esbuild.context(config);
  await ctx.watch();
  console.log('Watching JavaScript changes...');
}