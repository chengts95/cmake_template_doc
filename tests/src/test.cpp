
#include <gtest/gtest.h>

// Demonstrate some basic assertions.
TEST(ExampleTest, simpleAdd) {
  int a = 0;
  int b = 3;
  EXPECT_EQ(a+b,3);
}
