import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load the iris dataset
df = sns.load_dataset('iris')

# Display the first few rows of the dataset
print(df.head())

# Calculate the mean of each column
mean_values = df.mean()
print(mean_values)

# Create a histogram of the sepal_length column
plt.hist(df['sepal_length'], bins=10)
plt.xlabel('Sepal Length')
plt.ylabel('Frequency')
plt.title('Histogram of Sepal Length')
plt.show()