import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0', // Accessible on network
    port: 3001,
    strictPort: true, // Strict port enforcement
    proxy: {

      '/api': {
        target: 'http://localhost:3000/api', // Backend server (API Server)
        changeOrigin: true,
        secure: false,
        rewrite: (path) => path.replace(/^\/api/, ''),
      },

      '/jahrm-connect': {
        target: 'http://192.168.1.159:8090', // HRMIS server (API Server)
        changeOrigin: true,
      },

    }
  },

});