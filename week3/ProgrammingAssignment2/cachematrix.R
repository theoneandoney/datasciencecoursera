# ProgrammingAssignment2


# Matrix inversion is usually a costly computation and there may be some
# benefit to caching the inverse of a matrix rather than computing it
# repeatedly. This pair of functions will cache the inverse of a matrix.


## Creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinverse <- function(solve) i <<- solve
  getinverse <- function() i
  list(set = set, 
       get = get, 
       setinverse = setinverse, 
       getinverse = getinverse)
}


## Return a matrix that is the inverse of 'x',
## first by checking cache, then solving if not available

cacheSolve <- function(x = matrix(), ...) {
  ## if cached inverse matrix available, return it
  i <- x$getinverse()
  if(!is.null(i)){
    message("getting cached inverse matrix")
    return(i)
  }
  ## otherwise, solve inverse matrix and save in cache
  mdata <- x$get()
  i <- solve(mdata, ...)
  x$setinverse(i)
  i
}