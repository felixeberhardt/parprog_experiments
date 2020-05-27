#include <cstdlib>

#include <iostream>
#include <memory>
#include <regex>
#include <string>
#include <thread>
#include <vector>

class Workload {
public:

  virtual ~Workload() = default;

  virtual void run() = 0;
  virtual void join() = 0;
};

///////////////////////////////////////////////////////////////////////////////
// Workload1Acc
///////////////////////////////////////////////////////////////////////////////

template <typename T>
class Workload1Acc : public Workload {
public:

  Workload1Acc(size_t elements, size_t iterations)
  : m_elements { elements }
  , m_iterations { iterations } {}

  void workload() {
    volatile T acc;
    for(size_t iter; iter < m_iterations; ++iter) {
      acc = 1;
      for(size_t i = 0; i < m_elements; ++i) {
        acc += (acc * i + acc + i);
      }
    }
    m_result = acc;
  }

  T result() {
    return m_result;
  }

  virtual void run() override {
    m_thread = std::thread(&Workload1Acc<T>::workload, this);
  }

  virtual void join() override {
    if (m_thread.joinable())
      m_thread.join();
  }

private:
  size_t m_elements;
  size_t m_iterations;
  T m_result;

  std::thread m_thread;
};


///////////////////////////////////////////////////////////////////////////////
// Workload2Chase
///////////////////////////////////////////////////////////////////////////////

class Workload2Chase : public Workload {
public:

  Workload2Chase(size_t elements, size_t iterations)
  : m_elements { elements }
  , m_iterations { iterations }
  {
    m_array = reinterpret_cast<size_t *>(std::malloc(sizeof(size_t) * m_elements));
    if (!m_array)
      throw std::runtime_error("Workload2Chase(): could not allocate m_array");

    // initialize successor indices
    for(size_t i = 0; i < m_elements - 1; ++i) {
        m_array[i] = i + 1;
    }
    m_array[m_elements - 1] = 0;

    // shuffle indices
    std::srand((size_t) m_array);
    for(size_t i = m_elements - 1; i >= 0; --i) {
        size_t r = std::rand() % (m_elements - i);
        if(m_array[i] == r || m_array[r] == i) {
            continue;
        }
        if(m_array[m_array[i]] == r) {
            continue;
        }
        std::swap(m_array[i], m_array[r]);
    }
  }

  virtual ~Workload2Chase() {
    std::free(m_array);
  }

  void workload() {
    volatile size_t next;
    for(size_t iter; iter < m_iterations; ++iter) {
      next = 0;
      for(size_t i = 0; i < m_elements; ++i) {
        next = m_array[next];
      }
    }
    m_result = next;
  }

  size_t result() {
    return m_result;
  }

  virtual void run() override {
    m_thread = std::thread(&Workload2Chase::workload, this);
  }

  virtual void join() override {
    if (m_thread.joinable())
      m_thread.join();
  }

private:
  size_t m_elements;
  size_t m_iterations;
  size_t * m_array;
  size_t m_result;

  std::thread m_thread;
};


///////////////////////////////////////////////////////////////////////////////
// Workload3Sum
///////////////////////////////////////////////////////////////////////////////

template <typename T>
class Workload3Sum : public Workload {
public:

  Workload3Sum(size_t elements, size_t iterations)
  : m_elements { elements }
  , m_iterations { iterations }
  {
    m_array = reinterpret_cast<T *>(std::malloc(sizeof(T) * m_elements));
    if (!m_array)
      throw std::runtime_error("Workload3Sum(): could not allocate m_array");

    for(size_t i = 0; i < m_elements - 1; ++i) {
        m_array[i] = i + 1;
    }
    m_array[m_elements - 1] = 0;
  }

  virtual ~Workload3Sum() {
    std::free(m_array);
  }

  void workload() {
    volatile T sum;
    for(size_t iter = 0; iter < m_iterations; ++iter) {
      sum = 0;
      for(size_t i = 0; i < m_elements - 3; ++i) {
        sum += m_array[i] + 10 + m_array[i + 1] * 3 + m_array[i + 2] / 2 + m_array[i + 3] - 3;
      }
    }
    m_result = sum;
  }

  T result() {
    return m_result;
  }

  virtual void run() override {
    m_thread = std::thread(&Workload3Sum<T>::workload, this);
  }

  virtual void join() override {
    if (m_thread.joinable())
      m_thread.join();
  }

private:
  size_t m_elements;
  size_t m_iterations;
  T * m_array;
  T m_result;

  std::thread m_thread;
};


///////////////////////////////////////////////////////////////////////////////
// Workload4Branch
///////////////////////////////////////////////////////////////////////////////

class Workload4Branch : public Workload {
public:

  Workload4Branch(size_t elements, size_t iterations)
  : m_elements { elements }
  , m_iterations { iterations }
  {
    m_array = reinterpret_cast<bool *>(std::malloc(sizeof(bool) * m_elements));
    if (!m_array)
      throw std::runtime_error("Workload4Branch(): could not allocate m_array");

    std::srand((size_t)m_array);
    for(size_t i = 0; i < m_elements; ++i) {
      m_array[i] = std::rand() & 0x1;
    }
  }

  virtual ~Workload4Branch() {
    std::free(m_array);
  }

  void workload() {
    volatile long sum;
    for(size_t iter; iter < m_iterations; iter++) {
      sum = 0;
      for(size_t i = 0; i < m_elements - 3; i++) {
        if(m_array[i] == 1) {
          sum += i;
        }
      }
    }
    m_result = sum;
  }

  size_t result() {
    return m_result;
  }

  virtual void run() override {
    m_thread = std::thread(&Workload4Branch::workload, this);
  }

  virtual void join() override {
    if (m_thread.joinable())
      m_thread.join();
  }

private:
  size_t m_elements;
  size_t m_iterations;
  bool * m_array;
  size_t m_result;

  std::thread m_thread;
};

///////////////////////////////////////////////////////////////////////////////
// main():
//   Parse arguments and launch workloads.
///////////////////////////////////////////////////////////////////////////////

Workload * create_workload(const std::string & kind, size_t elements, size_t iterations) {
  if (kind == "1f") {
    return new Workload1Acc<float>(elements, iterations);
  } else if (kind == "1d") {
    return new Workload1Acc<double>(elements, iterations);
  } else if (kind == "1i") {
    return new Workload1Acc<size_t>(elements, iterations);
  } else if (kind == "2") {
    return new Workload2Chase(elements, iterations);
  } else if (kind == "3f") {
    return new Workload3Sum<float>(elements, iterations);
  } else if (kind == "3d") {
    return new Workload3Sum<double>(elements, iterations);
  } else if (kind == "3i") {
    return new Workload3Sum<size_t>(elements, iterations);
  } else if (kind == "4") {
    return new Workload4Branch(elements, iterations);
  } else {
    return nullptr;
  }
}

int main(int argc, char ** argv) {
  std::regex argpat("([0-9]+)x(1f|1d|1i|2|3f|3d|3i|4):([0-9]+)/([0-9]+)");
  std::cmatch match;

  std::vector<std::unique_ptr<Workload>> workloads;
  for (int iArg = 1; iArg < argc; ++iArg) {
    if (!std::regex_match(argv[iArg], match, argpat)) {
      std::cout << "Invalid argument \"" << argv[iArg] << "\"" << std::endl;
      return 1;
    }
    size_t copies = std::stoull(match[1].str());
    size_t elements = std::stoull(match[3].str());
    size_t iterations = std::stoull(match[4].str());
    for (size_t iCpy = 0; iCpy < copies; ++iCpy) {
      std::cout << "Workload" << match[2].str() << "(" << elements << ", " << iterations << ")" << std::endl;
      workloads.emplace_back(create_workload(match[2].str(), elements, iterations));
    }
  }

  std::cout << "Starting " << workloads.size() << " workloads" << std::endl;
  for (auto & workload : workloads) {
    workload->run();
  }

  for (auto & workload : workloads) {
    workload->join();
  }
  std::cout << "Finished workloads" << std::endl;

  return 0;
}


