| Issue | Table | Rows affected | How I will handle it |
| --- | --- | --- | --- |
| Price stored as text with $ sign | listings | all 17,499 | Strip symbols and cast to number in staging |
| Listings priced at 0 | listings | 8 | Flag as 'zero price', keep the rows |