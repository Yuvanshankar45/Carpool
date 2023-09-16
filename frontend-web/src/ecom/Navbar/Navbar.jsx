import React from 'react';
import {
  Box,
  Flex,
  Spacer,
  HStack,
  Input,
  Button,
  useMediaQuery,
} from '@chakra-ui/react';
import { SearchIcon } from '@chakra-ui/icons';

const Navbar = () => {
  const [isLargerThanTablet] = useMediaQuery('(min-width: 768px)');

  return (
    <Box bg="blue.500" p={4}>
      <Flex alignItems="center">
        {/* Logo */}
        <Box fontSize="2xl" fontWeight="bold" color="white" mr="2px">
          CarPool
        </Box>

        <Spacer />


        {isLargerThanTablet ? (
          <HStack spacing={6}>
            <Box color="white">Home</Box>
            <Box color="white">Services</Box>
            <Box color="white">Locations</Box>
            <Box color="white">About</Box>
            <Box color="white">Login</Box>
          </HStack>
        ) : (
          <Button colorScheme="whiteAlpha" size="sm">
            Menu
          </Button>
        )}

        {/* Search Bar */}
        <Input
          type="text"
          placeholder="Search"
          size="sm"
          borderRadius="full"
          bg="white"
          ml={2}
          mr={2}
          display={isLargerThanTablet ? 'block' : 'none'}
        />
        <Button
          size="sm"
          bg="white"
          borderRadius="full"
          aria-label="Search"
          display={isLargerThanTablet ? 'block' : 'none'}
        >
          <SearchIcon />
        </Button>
      </Flex>
    </Box>
  );
};

export default Navbar;
