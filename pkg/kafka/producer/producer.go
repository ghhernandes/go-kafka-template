package producer

import (
	"context"
	"github.com/segmentio/kafka-go"
	"log"
)

type Writer interface {
	WriteMessages(context.Context, ...kafka.Message) error
	Close() error
}

type Producer struct {
	w Writer
}

func New(w Writer) (*Producer, error) {
	return &Producer{w: w}, nil
}

func (p *Producer) Write(ctx context.Context, msgs []kafka.Message) error {
	err := p.w.WriteMessages(ctx, msgs...)
	if err != nil {
		log.Print("failed to write messages:", err)
        return err
	}
	return nil
}

func (p *Producer) Close() error {
	if err := p.w.Close(); err != nil {
		log.Fatal("failed to close producer:", err)
		return err
	}
	return nil
}
