module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./app/components/**/*.{rb,erb,haml,html,slim,js}",
    "./config/initializers/simple_form.rb",
  ],
  theme: {
    screens: {
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      '2xl': '1536px',
      '1700': '1700px',
    },
    extend: {
      fontFamily: {
        sans: ["Nunito", "ui-sans-serif", "system-ui", "sans-serif"],
        serif: ["Playfair Display", "serif"],
      },
      colors: {
        // Text
        '333333': '#333333', // principal
        '7d7d7d': '#7d7d7d', // secondary
        f5f5f5: '#f5f5f5', // light

        
        // Border
        e0e0e0: '#e0e0e0',
        ffffff: '#ffffff',
        
        
        // Background
        fdfdfd: '#fdfdfd',
        f7f7f7: '#f7f7f7',

        // Background color
        primary: '#b8a9c9',
        primary_dark: '#a69bc4',
        primary_light: '#d6c7e7',
        secondary: '#88c0d0',
        secondary_dark: '#76b2cb',
        secondary_light: '#a6deee',
      },
      boxShadow: {
        primary: '4px 4px 4px 0 rgba(0,0,0,0.25)',
        light: '4px 4px 4px 0 rgba(0,0,0,0.1)',
        dark: '4px 4px 4px 0 rgba(0,0,0,0.4)',
      },
      fontSize: {
        '2xs': ['0.625rem', { lineHeight: '0.75rem' }],
        'xl-mid': ['1.75rem', { lineHeight: '1.75rem' }],
      },
      lineHeight: {
        'extra-tight': '0.75rem',
      },
      spacing: {
        '1/13': '7.692%',
        '2/13': '15.385%',
        '3/13': '23.077%',
        '4/13': '30.769%',
        '5/13': '38.462%',
        '6/13': '46.154%',
        '7/13': '53.846%',
        '8/13': '61.538%',
        '9/13': '69.231%',
        '10/13': '76.923%',
        '11/13': '84.615%',
        '12/13': '92.308%',
        '13/13': '100%',
        '1/9': '11.111%',
        '2/9': '22.222%',
        '3/9': '33.333%',
        '4/9': '44.444%',
        '5/9': '55.556%',
        '6/9': '66.667%',
        '7/9': '77.778%',
        '8/9': '88.889%',
        '9/9': '100%',
      },
    },
  },
  safelist: [
    'w-1/13',
    'w-2/13',
    'w-3/13',
    'w-4/13',
    'w-5/13',
    'w-6/13',
    'w-7/13',
    'w-8/13',
    'w-9/13',
    'w-10/13',
    'w-11/13',
    'w-12/13',
    'w-13/13',
    'w-1/4',
    'w-2/4',
    'w-3/4',
    'w-4/4',
    'w-1/9',
    'w-2/9',
    'w-3/9',
    'w-4/9',
    'w-5/9',
    'w-6/9',
    'w-7/9',
    'w-8/9',
    'w-9/9',
    'w-1/5',
    'w-2/5',
    'w-3/5',
    'w-4/5',
    'w-5/5',
    'shadow-primary',
  ],
  plugins: [],
};
