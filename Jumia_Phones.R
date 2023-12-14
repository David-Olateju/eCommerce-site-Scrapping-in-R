# R library to scrape data
library(rvest)

# R package for string manipulation
library(stringr) 



# 1. READING THE DATA

# link to the website: jumia's
link = "https://www.jumia.com.ng/mlp-jumia-express-top-deals/mobile-phones/"


# reading the link
webpage = read_html(link)


# fetching the data elements based on the class tag name, ".name" and converting it to text
product = html_nodes(webpage, ".name") %>% 
  html_text2()


# this was used to fetch the original_price on the page
original_price = webpage %>% 
  html_nodes(".old") %>% 
  html_text()


# this was used to fetch the discounted_price on the page
discounted_price = webpage %>% 
  html_nodes(".prc") %>%
  html_text()


# this was used to fetch the discount rate on the page.
discount = webpage %>% 
  html_nodes("._sm") %>% 
  html_text()




# 2. DATA(strings here) MANIPULATION: here, the beauty of the stringr package will be seen.
# Regular Expressions will be used with the functions in the stringr library, as it is much more accurate and easier to extract strings with.

# extracting the name of the products using regular_expressions ::- (?= \\d) looked ahead and the words behind and all the characters that were behind it were extracted..
name = str_extract(product, "(\\d| |\\w)*(?= \\d)")


# all characters that had the specified variations of "GB" and "RAM" with them were used to extract the ram of each product
pre_ram = str_extract(product, pattern= "[\\d](GB|gb|GB/)( |)(RAM|ram|)")


# the outputs from the code above were not really accurate, so we had to use the "str_sub()" functions to extract just the digits
ram= str_sub(pre_ram, start= 0, end= 1)
ram


# the same thing that was applied to get the RAM above was used to get the ROM (internal storage)
pre_rom = str_extract(product, pattern= "..(GB|gb)( |)(ROM|rom)")
pre_rom


# to get the ROM digits, I tried Regular Expressions here, just so I could try to achieve the same result, which was successful.
rom = str_extract(pre_rom, "(\\d\\d|\\d\\d\\d)")



# this was used to extract the color of each product from the "product" variable
color = str_extract(product, "(?<= - | -)(\\w| )*")




# 3. CONVERTING THE DATA INTO A DATAFRAME
phones = data.frame(
  name = name,
  ram= ram,
  internal_storage= rom,
  color= color,
  original_price = original_price,
  discount = discount,
  discounted_price = discounted_price
)


head(phones)