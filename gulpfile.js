require('coffee-script/register');
require('require-dir')('./gulp');

/* gulp tasks:
 * default   -- recompiles entire public folder, starts a webserver, and watches src/
 * build     -- recomples source, minifies, and builds to dist/
 * serveDist -- serve dist/ folder to check the build
 * deploy    -- deploys dist/ folder to gh-pages (build first!)
 */
