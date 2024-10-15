import pandas as pd
df = pd.read_csv(r'C:\Users\2019\Downloads\Retail Order\orders.csv')
print(df['Ship Mode'].unique())

# rename columns names ..make them Lower case and replace space with underscore
# df.rename(columns={'Order Date': 'order_date', 'City': 'city'})
# print(df)
# print(df.columns)
# print(df.columns.str.replace(" ", "_"))
print(df.head(5))

# derive new columns discount, Sale Price, profit
df['discount'] = df['List Price']*df['Discount Percent']*.01
df['Sale Price'] = df['List Price'] - df['discount']
df['profit'] = df['Sale Price']-df['cost price']
# print(df)


# convert order date from object data type to datetime
# print(df.dtypes)
df['Order Date'] = pd.to_datetime(df['Order Date'], format="%Y-%m-%d")
# print(df)


# drop cost price list price and discount percent columns
# print(df.dtypes)
df.drop(columns=['cost price', 'List Price', 'discount'], inplace=True)
df
print(df)
