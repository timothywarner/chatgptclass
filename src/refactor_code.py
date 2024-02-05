class student:
  def __init__(self,n,r):
    self.name=n
    self.roll=r
    self.grades = [90, 85, 77, 92, 88]

  def get_average(self):
    total = 0
    for i in self.grades:
      total += i
    return total / len(self.grades)

  def get_grade(self):
    avg = self.get_average()
    if avg >= 90: return 'A'
    elif avg >= 80: return 'B'
    elif avg >= 70: return 'C'
    elif avg >= 60: return 'D'
    else: return 'F'

  def printStudent(self):
    print('Name:', self.name)
    print('Roll:', self.roll)
    print('Average:', self.get_average())
    print('Grade:', self.get_grade())

s1 = student('John', 1)
s1.printStudent()