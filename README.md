# slides-with-revealjs

build dockerfile
```docker build -t slides . ```

edit index.html and example.md files and then run docker image with blind volume mount 

```docker run -it  -v "$(pwd)"/src:"/data"  -p 8000:8000 --rm  slides:latest ```


url : http://localhost:8000
print-preview: http://localhost:8000/?print-pdf
