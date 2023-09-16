import { extendTheme } from '@chakra-ui/react';

const theme = extendTheme({
  fonts: {
    heading: 'Montserrat, sans-serif',
    body: 'Roboto, sans-serif',
  },
  colors: {
    primary: {
      50: '#f4f8ff',
      500: '#3498db',
      700: '#217dbb',
    },
    secondary: {
      50: '#f6f6f6',
      500: '#ff9800',
      700: '#e68a00',
    },
  },

});

export default theme;
