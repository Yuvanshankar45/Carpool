import React, { useState } from "react";
import {
  Box,
  Flex,
  Spacer,
  HStack,
  Input,
  Button,
  useMediaQuery,
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalCloseButton,
  ModalBody,
  ModalFooter,
  Text,
  Stack,
} from "@chakra-ui/react";
import { SearchIcon } from "@chakra-ui/icons";

const Navbar = () => {
  const [data, setData] = React.useState("");
  const [isLargerThanTablet] = useMediaQuery("(min-width: 768px)");
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const toggleMobileMenu = () => {
    setIsMobileMenuOpen(!isMobileMenuOpen);
  };

  return (
    <Box bg="blue.500" p={4}>
      <Flex alignItems="center">
        {/* Logo */}
        <Box fontSize="2xl" fontWeight="bold" color="white">
          YourLogo
        </Box>

        <Spacer />

        {/* Navigation Links */}
        {isLargerThanTablet ? (
          <HStack spacing={6}>
            <Box color="white">Home</Box>
            <Box color="white">Services</Box>
            <Box color="white">Locations</Box>
            <Box color="white">About</Box>
            <Box color="white">Login</Box>
          </HStack>
        ) : (
          <Button colorScheme="whiteAlpha" size="sm" onClick={toggleMobileMenu}>
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
          display={isLargerThanTablet ? "block" : "none"}
        />
        <Button
          size="sm"
          bg="white"
          borderRadius="full"
          aria-label="Search"
          display={isLargerThanTablet ? "block" : "none"}
        >
          <SearchIcon />
        </Button>
      </Flex>

      {/* Mobile Menu Modal */}
      {isMobileMenuOpen && (
        <Modal isOpen={isMobileMenuOpen} onClose={toggleMobileMenu}>
          <ModalOverlay />
          <ModalContent>
            <ModalHeader>Mobile Menu</ModalHeader>
            <ModalCloseButton />
            <ModalBody>
              <Stack spacing={4}>
                <Text fontSize="xl" fontWeight="bold" color="blue.500">
                  Home
                </Text>
                <Text fontSize="xl" fontWeight="bold" color="blue.500">
                  Services
                </Text>
                <Text fontSize="xl" fontWeight="bold" color="blue.500">
                  Locations
                </Text>
                <Text fontSize="xl" fontWeight="bold" color="blue.500">
                  About
                </Text>
                <Text fontSize="xl" fontWeight="bold" color="blue.500">
                  Login
                </Text>
              </Stack>
            </ModalBody>

            <ModalFooter></ModalFooter>
          </ModalContent>
        </Modal>
      )}
    </Box>
  );
};

export default Navbar;
