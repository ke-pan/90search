# This is a cli cmd to search text in json

## Give it a try

```
$ bin/ninety_search search data/users.json tags Sutton
```

## Usage

```
$ bin/ninety_searh search filename field text
```

## Advanced

Want a faster search for big file?

1. Setup a worker process
```
$ bin/ninety_search setup
```
2. Open a new terminal
3. Load file for search 
```
$ bin/ninety_search load filename
``` 
4. Search
```
$ bin/ninety_search search filename field text
```

## Test

```
$ bin/test
```
