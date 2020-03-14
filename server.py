import grpc
import time
from concurrent import futures
from tools import db_mgr as db
from grpcs import py


class FunnifyServiceServicer(py.auth_pb2_grpc.FunnifyServiceServicer):
    def authenticate(self, request, context):
        response = py.auth_pb2.AuthenticateResponse()
        result = response.result
        if request.provider == py.auth_pb2.GOOGLE:
            result.success = True
            response.sessionKey = "gg0123456789"
        elif request.provider == py.auth_pb2.FACEBOOK:
            result.success = True
            response.sessionKey = "fb0123456789"
        else:
            result.success = False
        print('authenticate() -> %s' % response.result.success)
        return response


db.init()
server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
py.auth_pb2_grpc.add_FunnifyServiceServicer_to_server(FunnifyServiceServicer(), server)
print('Starting "Funnify-gRPC-Server" on port 50051.')
server.add_insecure_port('165.246.42.172:50051')
server.start()

# since server.start() will not block, a sleep-loop is added to keep alive
try:
    while True:
        time.sleep(86400)
except KeyboardInterrupt:
    server.stop(0)
    db.end()
    print('Server has stopped.')
