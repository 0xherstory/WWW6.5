import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  base: './', // 👈 新增：让打包出来的代码引用全部使用相对路径
  plugins: [vue()],
  server: {
    port: 5174,
    host: '0.0.0.0',
    open: true
  },
  build: {
    outDir: 'dist',
    assetsDir: 'assets'
  }
})