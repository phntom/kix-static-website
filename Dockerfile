FROM klakegg/hugo as builder

COPY . /src/

ENV HUGO_ENV production
ENV HUGO_DESTINATION /public

RUN hugo --minify

FROM nginx

RUN sed -i 's/#error_page/error_page/' /etc/nginx/conf.d/default.conf

COPY --from=builder /public/ /usr/share/nginx/html/
