package main

import (
	"github.com/labstack/echo/v4"
	"log"
	"net/http"
)

func main() {
	e := echo.New()
	s := http.Server{
		Addr:    ":8080",
		Handler: e,
	}

	em := echo.New()
	sm := http.Server{
		Addr:    ":8081",
		Handler: em,
	}

	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})
	em.GET("/metrics", func(c echo.Context) error {
		return c.String(http.StatusOK, "Metrics!")
	})

	go func() {
		log.Print("Starting metrics server...")
		if err := sm.ListenAndServe(); err != http.ErrServerClosed {
			log.Fatal(err)
		}
	}()

	log.Print("Starting server...")
	if err := s.ListenAndServe(); err != http.ErrServerClosed {
		log.Fatal(err)
	}
}
