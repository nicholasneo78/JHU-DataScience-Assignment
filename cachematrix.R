## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
# This function computes the inverse of the special
# 'matrix' object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  k <- NULL
  set <- function(y){
    x <<- y
    k <<- NULL
  }
  get <-function() x
  setinv <- function(inv) k <<- inv
  getinv <- function() k
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}

## Write a short comment describing this function
#' This function computes the inverse of the special
#' "matrix" returned by makeCacheMatrix above
#' If the inverse has already been calculated,
#' then cacheSolve should retrieve the 
#' inverse from the cache
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  k <- x$getinv()
  if(!is.null(k)) {
    message("getting cached data")
    return(k)
  }
  data <- x$get()
  k <- solve(data, ...)
  x$setinv(k)
  k
}

# test case
x = rbind(c(1,0,0), c(0,1,0), c(0,0,1))
m = makeCacheMatrix(x)
cacheSolve(m)
