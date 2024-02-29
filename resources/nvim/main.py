class Adder:
    def __init__(self,a: int, b: int) -> None:
        self.a = a 
        self.b = b

    def print_out(self):
        print(f"Adding {self.a} and {self.b}")

    def add(self):
        self.print_out()
        return self.a + self.b


if __name__ == '__main__':
    adder = Adder(2,5)
    adder.add()

