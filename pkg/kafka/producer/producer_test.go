package producer

import (
	"context"
	"errors"
	"testing"

	"github.com/segmentio/kafka-go"
)

type FakeWriter struct {
	Error bool
}

func (p *FakeWriter) WriteMessages(ctx context.Context, msgs ...kafka.Message) error {
    if p.Error {
        return errors.New("Testing error")
    }
	return nil
}

func (p *FakeWriter) Close() error {
	return nil
}

func TestWriteSuccess(t *testing.T) {
	producer, _ := New(&FakeWriter{Error: false})
    defer producer.Close()

	messages := []kafka.Message{
		{Key: []byte("key1"), Value: []byte("message 1")},
		{Key: []byte("key2"), Value: []byte("message 2")},
		{Key: []byte("key3"), Value: []byte("message 3")},
	}
    err := producer.Write(context.Background(), messages)
    if err != nil {
        t.Error("Unexpected error found")
    }
}

func TestWriteError(t *testing.T) {
	producer, _ := New(&FakeWriter{Error: true})
    defer producer.Close()
    err := producer.Write(context.Background(), []kafka.Message{})
    if err == nil {
        t.Error("Expected error not found!")
    }
}
