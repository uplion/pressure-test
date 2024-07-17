wrk.method = "POST"
wrk.host = os.getenv("TEST_HOST")
wrk.port = os.getenv("TEST_PORT") or 80
wrk.body   = '{"model": "static","messages": [{"role": "user","content": "Hello"}]}'
wrk.headers["Content-Type"] = "application/json"
done = function(summary, latency, requests)
--    io.write("Threads,Connections,Duration,Requests,Requests/sec,Transfer/sec,Avg Latency\n")
    io.write(string.format("%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f\n",
        latency.min, latency.max, latency.mean, latency.stdev, latency:percentile(50), latency:percentile(95), latency:percentile(99),latency:percentile(99.9)),
        requests.min, requests.max, requests.mean, requests.stdev, requests:percentile(50), requests:percentile(95), requests:percentile(99),requests:percentile(99.9),
        summary.duration, summary.requests, summary.bytes, summary.errors.connect, summary.errors.read, summary.errors.write, summary.errors.status, summary.errors.timeout
    )
end