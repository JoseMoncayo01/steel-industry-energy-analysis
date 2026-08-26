import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# LOAD DATA FILE

df = pd.read_csv('data/Steel_industry_data.csv')
print('Dataset Loaded')
print(df.head())
# ==============================================================================

# VERIFY DATA STRUCTURE

print('\nDataset Info: ')
print(df.info()) 

# Convert 'date' column
df['date'] = pd.to_datetime(df['date'], dayfirst=True)
print(df.info())

# Create 'hour' column
df['Hour'] = df['date'].dt.hour
print(df.head())
print(df.info())
# ==============================================================================

# DATA UNDERSTANDING

print('\nDataset Columns:')
print(df.columns)

print('\nStatistical Summary:')
print(df.describe(include='all'))

print('\nValues in "Load_Type" Column:')
print(df['Load_Type'].value_counts())

print('\nValues in "WeekStatus" Column:')
print(df['WeekStatus'].value_counts())

print('\nNull Values:')
print(df.isnull().sum())

print('\nDuplicated Values:')
print(df.duplicated().sum())
# ==============================================================================

# EXPLORATORY DATA ANALYSIS

hourly_usage = (df.groupby('Hour')['Usage_kWh'].mean())
print(hourly_usage)

plt.figure(figsize=(10,5))

plt.plot(hourly_usage.index, hourly_usage.values)

plt.title('Average Energy Consumption by Hour')
plt.xlabel('Hour')
plt.ylabel('Average Usage (kWh)')
plt.grid(True)
plt.tight_layout()
plt.savefig('outputs/charts/01_avg_hourly_consumption.png', bbox_inches='tight')
plt.show()

# -----------------------

daily_usage = (df.groupby('Day_of_week')['Usage_kWh'].mean())
print(daily_usage)

daily_order = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
]

daily_usage = (df.groupby('Day_of_week')['Usage_kWh'].mean().reindex(daily_order))
plt.figure(figsize=(8,5))
daily_usage.plot(kind='bar')

plt.title('Average Energy Consumption by Day')
plt.xlabel('Day of Week')
plt.ylabel('Average Usage (kWh)')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('outputs/charts/02_avg_daily_consumption.png', bbox_inches='tight')
plt.show()

# -----------------------

week_status_usage = (df.groupby('WeekStatus')['Usage_kWh'].mean())
print(week_status_usage)
week_status_usage.plot(kind='bar')

plt.title('Energy Consumption: Weekday vs Weekend')
plt.ylabel('Average Usage (kWh)')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('outputs/charts/03_weekday_vs_weekend.png', bbox_inches='tight')
plt.show()

weekday = week_status_usage['Weekday']
weekend = week_status_usage['Weekend']

difference = (weekday / weekend)
print('\nDifference:')
print(difference)
# ==============================================================================

# OPERATIONAL ANALYSIS

load_usage = (df.groupby('Load_Type')['Usage_kWh'].mean())
print(load_usage)

plt.figure(figsize=(8,5))
load_usage.plot(kind='bar')

plt.title('Average Energy Consumption by Load Type')
plt.xlabel('Load Type')
plt.ylabel('Average Usage (kWh)')
plt.xticks(rotation=0)
plt.tight_layout()
plt.savefig('outputs/charts/04_avg_load_type_consumption.png', bbox_inches='tight')
plt.show()

# -----------------------

correlation_matrix = (df.corr(numeric_only=True))
print(correlation_matrix)

plt.figure(figsize=(10,6))
sns.heatmap(correlation_matrix, annot=True)
plt.title('Correlation Heatmap')
plt.tight_layout()
plt.savefig('outputs/charts/05_correlation_heatmap.png', bbox_inches='tight')
plt.show()

# -----------------------

plt.figure(figsize=(10,5))
sns.boxplot(data=df, x='Load_Type', y='Usage_kWh', showfliers=False)

plt.title('Energy Consumption Distribution by Load Type')
plt.xlabel('Load Type')
plt.ylabel('Usage (kWh)')
plt.tight_layout()
plt.savefig('outputs/charts/06_energy_dist_by_load_boxplot.png', bbox_inches='tight')
plt.show()

# -----------------------

df['Month'] = (df['date'].dt.month_name())
month_order = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
]

monthly_usage = (df.groupby('Month')['Usage_kWh'].mean().reindex(month_order))
print(monthly_usage)

plt.figure(figsize=(10,5))
plt.plot(monthly_usage.index,monthly_usage.values)


plt.title('Average Energy Consumption by Month')
plt.xlabel('Month')
plt.ylabel('Average Usage (kWh)')
plt.xticks(rotation=45)
plt.grid(True)
plt.tight_layout()
plt.savefig('outputs/charts/07_monthly_consumption.png', bbox_inches='tight')
plt.show()
# ==============================================================================

# PIVOT TABLE

pivot_table = df.pivot_table(values='Usage_kWh', index='Day_of_week', columns='Hour', aggfunc='mean')
pivot_table = pivot_table.reindex(daily_order)

plt.figure(figsize=(12,5))
sns.heatmap(pivot_table, cmap='YlOrRd')
plt.title('Energy Consumption by Day and Hour')
plt.xlabel('Hour')
plt.ylabel('Day')
plt.tight_layout()
plt.savefig('outputs/charts/08_day_hour_heatmap.png', bbox_inches='tight')
plt.show()
# ==============================================================================

# EXPORT CLEAN DATASET

df.to_csv('data/cleaned_energy_data.csv', index=False)

print('\nClean dataset exported successfully.')