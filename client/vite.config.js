import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],

  server: {
    host: '0.0.0.0',
    port: 5173,
    headers: {
      "Cross-Origin-Opener-Policy": "same-origin",
      "Cross-Origin-Embedder-Policy": "require-corp"
    }
  },
  build: {
    outDir: 'dist', 
    sourcemap: false,
    rollupOptions: {
      output: {
        manualChunks(id) {
          // Create vendor chunk for React packages
          if (id.includes('node_modules/react-dom') || 
              id.includes('node_modules/react/')) {
            return 'vendor';
          }
          // Optional: Put other node_modules in the vendor chunk too
          if (id.includes('node_modules/')) {
            return 'vendor';
          }
        },
      },
    },
  },
})