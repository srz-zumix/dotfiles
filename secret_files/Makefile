SRC_DIR=src
DST_DIR=dst
TEXT_SRCS=$(wildcard $(SRC_DIR)/*.txt)
TEXT_DSTS=$(TEXT_SRCS:${SRC_DIR}/%=${DST_DIR}/%.gpg)

TARGETS=${TEXT_DSTS}

default: ${TARGETS}

clean:
	rm -rf ${TARGETS}

${DST_DIR}/%.gpg: ${SRC_DIR}/%
	echo ${PASSWD} | gpg --batch --passphrase-fd 0 --symmetric --cipher-algo AES256 --output $@ $<

${SRC_DIR}/%: ${DST_DIR}/%.gpg
	echo ${PASSWD} | gpg --quiet --batch --yes --decrypt --passphrase-fd 0 --output $@ $<
