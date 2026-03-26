
from app.utils.boot import boot
from app.utils.logger import logger

boot("test_sample")

def test_log():
    logger.info("Sample test running...")


def test_sum_one_plus_one():
    assert 1 + 1 == 2