#include <iostream>
#include <string>
#include <vector>

class Example {
  public:
    Example(int value) : m_value(value) {}

    void processData(const std::vector<int> &data) {
        for (auto item : data) {
            if (item > m_value) {
                std::cout << "Item " << item << " is greater than " << m_value << std::endl;
            } else {
                std::cout << "Item " << item << " is not greater" << std::endl;
            }
        }
    }

  private:
    int m_value;
};

int main() {
    Example ex(10);
    std::vector<int> data = {5, 15, 8, 20, 3};
    ex.processData(data);
    return 0;
}
