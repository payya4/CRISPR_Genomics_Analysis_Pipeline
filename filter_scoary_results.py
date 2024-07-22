import pandas as pd

# Load the data
df = pd.read_csv('/Users/yaz/Desktop/scoary_25_1.4_output_new/CRISPR_Presence_30_06_2024_1908.results.csv')

# Display the first few rows to understand the structure
print(df.head())

# Filter out rows where the 'gene' column contains 'group_'
filtered_df = df[~df['Gene'].str.startswith('group_')]

# Save the filtered data to a new CSV file
filtered_df.to_csv('~/Desktop/filtered_data_1.4_new.csv', index=False)
