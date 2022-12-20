# Things to be Noticed
----

1. **All folders may not be multileveled folders. Only single level.**
   The following structure is not allowed.
   ```
   - core
	   - adapters
		   - Adapter.jsp
	   - db
		   - DbInstance.jsp
   ```
   
   The following structure is OK.
   ```
   - core_adapters
	   - Adapter.jsp
   - core_db
	   - DbInstance.jsp
	```

2. **All user defined object are imported in views to avoid import collision. (Ex.: import model in login controller instead of login repository)**
3. **Database Configurations are defined in `DbConfig.jsp`.**
4. **The template is for the following flow:**
 ```
 Repository -> Controller/View Model -> View
 ```
**not**
 
 ```
 BE Repository -> BE Controller -> FE Repository -> FE Controller/View Model -> View
 ```
5. **Each repository only connects to one database/data source**

6. **How to use the codes are demonstrated in `Example*.jsp`**

The codes has been tested in Java, not in Jsp. Might need minor changes.\
`DbInstances.jsp` codes were used previously and worked. (Except the part where entities are automated)

## Dependency Flow
```
DbConfig ← DbInstance ← Repository ← Views
              ↓             ↓
            Entity       Adapter
```