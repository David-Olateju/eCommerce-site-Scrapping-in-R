# WEB SCRAPPING IN R

This Project is focused towards Web Scrapping in R and performing basic data manipulation.The Website ("https://www.jumia.com.ng/mlp-jumia-express-top-deals/mobile-phones/") used was an eCommerce website (Jumia), which is a popular eCommerce site here in Nigeria. 

Libraries used were:

1) rvest - short for "harvest", which was used to scrape the data.
2) stringr - which was used for sting manipulation.


### LOADING THE LIBRARIES
![Screenshot from 2023-12-14 13-07-42](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/74cc5ce0-2a62-46d2-9364-e9f00a55c16e)



### DATA IMPORT

The link used was assigned the be variable "link" for readability.
![1](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/ec98d741-40f8-4992-8f1b-00cf54fda65a)

The link was read into the environment using "read_html()" function into the variable "webpage" 
![2](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/6df902ee-77e5-42c8-9186-165d1cf680f4)


The specific data elements we want on the page can be fetched by referring to their tag names.

Here, "html_nodes" was used to fetch the elements of the tag specified, and "html_text2" converted them to texts.
![3](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/7083c221-172f-4d0a-bd91-a9fdc43b440b)


The Original Prices of the products were gotten from the tag name. There was a promo going on as at the time of scrapping this project, hence the variable name.
![4](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/23148812-24cc-49fb-944d-b29877d43c3e)


The discount price was gotten using its tag's name.
![5](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/0df49cd4-044e-46b9-a4ec-c5087450a76d)


The discount rate was also gotten the as well.
![6](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/1c2a8eba-2305-4fd2-ab51-1996b1690c34)



### DATA MANIPULATION
For the data assigned to variable "product", we could see that it is a string of characters about the full description of the Phones, but this is not suitable for a data frame, and the contents can be separated to give a much readable description of the products.

So, we will make it readable and suitable for a data frame.

Here, Regular Expressions will be used together with the "stringr" package loaded above to manipulate the data for accurate results.

![7](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/a3c6600c-87bd-4305-ae85-70bea5a31b0c)



#### Extracting the product names.

Regular Expressions used there were:

1) (?= \\\d) - this was used to "lookahead" of any occurrence of digits with a space behind them.

2) (\\\d| |\\\w)* - this was used to select all the whitespaces, zero or more(*)

Combining both together, we have: "lookahead of any digit with a space behind, and select zero or more characters with spaces and digits behind them) and extract the strings"

![8](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/e80e0033-3e12-4f4b-b826-72bd9fb6245f)



#### Extracting the RAM.

The Regular Expressions used:

1) [\\\d] - any digits

2) (GB|gb|GB/) - any characters that match with "GB" or "gb" or "GB/"

3) ( |) - any occurrence of a space or not.

4) (RAM|ram|) - any occurrence of characters that match "RAM" or "ram" or an empty character.

combining all, we have, "extract all the digits that have any variations of the characters of RAM specified that comes before the occurrence of any white-space (or none), which comes before any variation of "RAM" specified or none."

![9](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/da5bf7c2-040d-464c-8841-c80c962615de)


The output gotten (as seen above) contains some redundant words, and we are only interested in the digits (or the first character).
So, we will use the the the "str_sub" function to extract exactly what we are interested in, which was the first character of the output, which is specified below.

![10](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/f1531957-a72b-47c1-93c6-07aaf948a159)


#### Extracting the ROM

Almost the same thing that was applied to extract the RAM above will the applied to extract the ROM, the only difference is the usage of two dots.
"Extract the two characters that have the occurrences of any variations of "GB" in front it, that comes before the existence of a space (or not), which comes before the existence of any variation of "ROM" specified."

![11](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/4abe18db-4296-4ce6-9d30-1b547fc89144)


The digits will be extracted below. Here, I used Regular Expressions to extract the digits as it's more flexible.

(\\\d\\\d) - 2 digits

(\\\d|\\\d|\\\d) - 3 digits

The code will extract 2 or more digits in the output above.

![12](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/41a568a3-b89f-4e12-9235-7526ddc80e48)


#### Extracting the Colors

The code used::
1) (?<= - | -): "lookabehind any occurence of 'whitespace hyphen whitespace ( - )' or 'whitespace hypen ( -)'"

2) (\\\w| )* : select all the words or whiteaspaces.

Combining them, "lookahead of any occurrence of any 'whitespace hyphen whitespace' or 'whitespace hyphen' and select all the words that come after them with or without whitespaces"

![13](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/6cf10f5a-93db-4989-acff-aa72ab28d534)


### LOADING AS A DATAFRAME
After the successful manipulation of the data, it will be loaded into a DataFrame as shown below:

![14](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/7d59387c-604f-4607-9e38-2fb1164f50e3)


And the final result is shown below:

![1](https://github.com/David-Olateju/eCommerce-site-Scrapping-in-R/assets/129637983/7575f2a6-929a-4178-8bfa-85bfbf45109c)


### THANKS FOR READING THROUGH.
I hope you've learnt a thing or two?




