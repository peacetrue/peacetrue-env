# see https://blog.logrocket.com/how-to-build-component-library-react-typescript/
# 硬链接复用：ln -f $workingDir/learn-make/react-lib.mk frontend-lib.mk

# make -f "$workingDir/learn-make/react-lib.mk" create/
create/%:
	mkdir -p $*
	ln -f $$workingDir/learn-make/react-lib.mk $*/react-lib.mk

.gitignore:
	printf "$$gitignore" > "$@"
define gitignore
# See https://help.github.com/articles/ignoring-files/ for more about ignoring files.

# dependencies
/node_modules
/.pnp
.pnp.js

# testing
/coverage

# production
/build

# misc
.DS_Store
.env.local
.env.development.local
.env.test.local
.env.production.local

npm-debug.log*
yarn-debug.log*
yarn-error.log*

.idea
dist
*storybook.log
endef
export gitignore
git-init:
	git init
	sed -i '' 's/'"$old_text"'/'"$new_text"'/g' filename.txt

npm-init:
	rm -rf package.json
	npm init -y
npm-init/package.json:
	sed -i 's/xiayx/peacetrue/' package.json
	sed -i '/"main"/d' package.json
	sed -i '/version/a\ '"$$package_module"'' package.json
define package_module
  "files": ["src","dist"],"source": "src/index.js","main": "dist/index.js","types": "dist/index.d.ts","module": "dist/index.mjs",
endef
export package_module

# ts-node for jest.config.ts <- jest.config.js
npm-install-ts:
#	pnpm i typescript ts-node --save-dev
	pnpm i @types/node --save-dev
#	npm i tslib --save-dev
npx-tsc-init:
	npx tsc -init
tsconfig.json:
	printf "$$tsconfig" > $@
define tsconfig
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx"
  },
  "include": ["src"]
}
endef
export tsconfig

npm-install-react:
	pnpm i react react-dom
	pnpm i @types/react @types/react-dom --save-dev

npm-install-jest:
	npm install @testing-library/react jest @types/jest jest-environment-jsdom --save-dev
jest/package.json:
	sed -i '/"test":/d' package.json
	sed -i '/"scripts": {/a\\t"test": "jest",' package.json
jest.config.js:
	printf "$$jest_config" > $@
define jest_config
// jest.config.js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: {
    ".(css|less|scss)$$": "identity-obj-proxy",
  },
};
endef
export jest_config

npm-install-babel:
	pnpm install @babel/core @babel/preset-env babel-jest --save-dev
npm-install-babel-typescript:
	pnpm install @babel/preset-typescript --save-dev
npm-install-babel-react:
	pnpm install @babel/preset-react --save-dev
npm-install-identity-obj-proxy:
	npm install identity-obj-proxy -save-dev
babel.config.js:
	printf "$$babel_config" > $@
define babel_config
// babel.config.js
module.exports = {
    presets: [
      "@babel/preset-env",
      "@babel/preset-typescript",
//      "@babel/preset-react",
    ],
 };
endef
export babel_config

# npx 是 npm 5.2.0 中引入的一个工具，专门用于执行 Node.js 包中的二进制文件。
npx-sb-init:
	mkdir -p src # 自动生成的示例位于 src 下（自动探测 src 目录）
	npx sb init --type react --builder webpack5 --yes

src/components/smartrating:
	mkdir -p $@
	echo "export * from './components';" > src/index.ts
	echo "export * from './smartrating';" > '$(dir $@)index.ts'
	echo "export * from './SmartRating';" > '$@/index.ts'
	printf "$$SmartRating_types" > '$@/SmartRating.types.ts'
	printf "$$SmartRating_css" > '$@/SmartRating.css'
	printf "$$SmartRating" > '$@/SmartRating.tsx'
	printf "$$SmartRating_test" > '$@/SmartRating.test.tsx'
	printf "$$SmartRating_story" > '$@/SmartRating.stories.tsx'
define SmartRating_types
export interface SmartRatingProps {
    testIdPrefix: string;
    title?: string;
    theme: "primary" | "secondary";
    disabled?: boolean;
}
endef
export SmartRating_types
define SmartRating_css
body {
    padding: 100px;
    font-size: large;
    text-align: left;
  }

span {
    margin-left: 10px;
    background-color: transparent;
    border: none;
    outline: none;
    cursor: pointer;
    :hover {
      color: grey;
    }
  }

  .star{
    font-size: large;
  }
  .starActive {
    color: red;
  }
  .starInactive {
    color: #ccc;
  }

  .rating-secondary {
    background-color: black;
    color: white;
    padding:6px;
  }
endef
export SmartRating_css
define SmartRating
import React, { useState } from "react";
import "./SmartRating.css";
import { SmartRatingProps } from "./SmartRating.types";

export const SmartRating: React.FC<SmartRatingProps> = (props) => {
  const stars = Array.from({ length: 5 }, (_, i) => i + 1);
  const [rating, setRating] = useState(0);
  return (
    <div className={`star-rating rating-$${props.theme}`}>
      <h1>{props.title}</h1>
      {stars.map((star, index) => {
        const starCss = star <= rating ? "starActive" : "starInactive";
        return (
          <button
            disabled={props.disabled}
            data-testid={`$${props.testIdPrefix}-$${index}`}
            key={star}
            className={`$${starCss}`}
            onClick={() => setRating(star)}
          >
            <span className="star">★</span>
          </button>
        );
      })}
    </div>
  );
};
endef
export SmartRating
define SmartRating_story
// smartRating.stories.tsx
import React from "react";
import { StoryFn, Meta } from "@storybook/react";
import {SmartRating} from "./SmartRating";

export default {
  title: "ReactComponentLibrary/Rating",
  component: SmartRating,
} as Meta<typeof SmartRating>;

const Template: StoryFn<typeof SmartRating> = (args) => <SmartRating {...args} />;

export const RatingTest = Template.bind({});
RatingTest.args = {
  title: "Default theme",
  theme: "primary",
  testIdPrefix: "rating",
};

export const RatingSecondary = Template.bind({});
RatingSecondary.args = {
  title: "Secondary theme",
  theme: "secondary",
  testIdPrefix: "rating",
};
endef
export SmartRating_story
define SmartRating_test
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import {SmartRating} from "./SmartRating";

describe("SmartRating", () => {
  test("renders the Rating component", () => {
    render(<SmartRating title="default" theme="primary" testIdPrefix="rating" />);

    expect(screen.getByRole("heading").innerHTML).toEqual("default");
    expect(screen.getAllByRole("button", { hidden: true }).length).toEqual(5);
  });

  test("click the 5 star rating", async () => {
    const stars = [0, 1, 2, 3, 4];
    render(<SmartRating title="default" theme="primary" testIdPrefix="rating" />);

    stars.forEach(async (star) => {
      const element = screen.getByTestId("rating-" + star);
      userEvent.click(element);
      await waitFor(() => expect(element.className).toBe("starActive"));
    });
  });
});
endef
export SmartRating_test

npm-install-rollup:
	pnpm install -D rollup
	pnpm install -D @rollup/plugin-node-resolve # 按照 node 的方式解析依赖
	pnpm install -D @rollup/plugin-typescript # 这个插件让 Rollup 能够直接处理 TypeScript 文件，在打包过程中将它们编译为 JavaScript
	pnpm install -D rollup-plugin-visualizer
#	pnpm install -D @rollup/plugin-commonjs
#	pnpm install -D rollup-plugin-peer-deps-external @types/rollup-plugin-peer-deps-external # 这个插件会自动将 package.json 中的 peer dependencies 标记为外部依赖，防止它们被打包到最终输出中
#	pnpm install -D @types/rollup-plugin-dts rollup-plugin-dts  # 这个插件在 Rollup 构建过程中生成 TypeScript 声明文件（.d.ts）
#	pnpm install -D @rollup/plugin-terser # 这个插件使用 Terser（一个流行的 JavaScript 压缩工具）来压缩最终的打包文件
rollup/package.json:
	sed -i '/"main":/d' package.json
	sed -i '/"scripts": {/i\  "main": "dist/cjs/index.js",' package.json
	sed -i '/"scripts": {/i\  "module": "dist/esm/index.js",' package.json
	sed -i '/"scripts": {/i\  "types": "dist/index.d.ts",' package.json
	sed -i '/"scripts": {/a\    "build": "rollup -c --bundleConfigAsCjs",' package.json
rollup.config.js:
	printf "$$rollup_config" > $@
define rollup_config
import resolve from "@rollup/plugin-node-resolve";
import typescript from "@rollup/plugin-typescript";
import {visualizer} from "rollup-plugin-visualizer";

/** @type {[import("rollup").RollupOptions]} */
const rollupOptions = [{
    input: ['src/index.ts',],
    output: [
        {
            dir: 'dist',
            format: 'cjs',
            preserveModules: true,
            preserveModulesRoot: 'src',
            sourcemap: true,
        },
        {
            file: 'dist/index.mjs',
            format: 'esm',
            sourcemap: true,
        }
    ],
    plugins: [
        resolve(),
        typescript({tsconfig: "./tsconfig.json"}),
        // terser(), // 类库不需要压缩，由最终目标压缩
        // peerDepsExternal(),
        visualizer({filename: "stats.html", template: "treemap",}),
    ],
    external: [/node_modules/], // 外部化所有依赖
}];
export default rollupOptions;
endef
export rollup_config
npm-install-rollup-plugin-postcss:
	npm install rollup-plugin-postcss --save-dev
css/rollup.config.js:
	sed -i '/import peerDepsExternal/a\import postcss from "rollup-plugin-postcss";' rollup.config.js
	sed -i '/terser()/a\\t\t\tpostcss(),' rollup.config.js
	sed -i '/dts.default/a\\t\texternal: [/\.css$$/],' rollup.config.js
npm-install-rollup-plugin-visualizer:
	pnpm install --save-dev rollup-plugin-visualizer
visualizer/rollup.config.js:
	sed -i '/import peerDepsExternal/a\import { visualizer } from "rollup-plugin-visualizer";' rollup.config.js
	sed -i '/terser()/a\\t\t\tvisualizer({filename: "stats.html",template: "treemap",}),' rollup.config.js
npm-install-glob:
	pnpm install glob --save-dev

npm-install-parcel:
	pnpm install parcel --save-dev
parcel/package.json:
	sed -i '/"scripts": {/a\    "watch": "parcel watch",' package.json
	sed -i '/"scripts": {/a\    "build": "parcel build",' package.json
npm-uninstall-parcel:
	pnpm uninstall parcel


npm-view:
	npm view $(notdir $(shell pwd))
