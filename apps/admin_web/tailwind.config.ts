import type { Config } from 'tailwindcss';

export default {
  content: ['./src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        ink: {
          900: '#0A1628',
          800: '#142239',
          700: '#1F2D45',
          500: '#5A6478',
          300: '#A8B0BD',
          100: '#E4E8EE',
          50: '#F4F6FA',
        },
        coral: {
          700: '#CC3D32',
          500: '#FF5A4E',
          100: '#FFE5E2',
        },
        mint: {
          700: '#008F6B',
          500: '#00C896',
          100: '#D6F7EC',
        },
        amber: {
          500: '#FFB02E',
          100: '#FFEFCD',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        display: ['"Plus Jakarta Sans"', 'system-ui', 'sans-serif'],
      },
      borderRadius: {
        xl: '16px',
        '2xl': '20px',
        '3xl': '24px',
      },
    },
  },
  plugins: [],
} satisfies Config;
