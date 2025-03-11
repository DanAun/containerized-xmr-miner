# Stage 1: Build the xmrig binary
FROM alpine:latest AS builder

ARG XMRIG_URL="https://github.com/xmrig/xmrig.git"
ARG XMRIG_BUILD_ARGS="-DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON -DWITH_HWLOC=OFF"

RUN apk add --no-cache git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers

RUN git clone --single-branch --depth 1 "$XMRIG_URL" \
    && cd xmrig \
    && mkdir -p build \
    && sed -i 's/kDefaultDonateLevel = 1;/kDefaultDonateLevel = 0;/; s/kMinimumDonateLevel = 1;/kMinimumDonateLevel = 0;/;' src/donate.h \
    && cd scripts \
    && ./build_deps.sh \
    && cd ../build \
    && cmake .. $XMRIG_BUILD_ARGS \
    && make -j$(nproc)

# Stage 2: Create the final image
FROM alpine:latest
RUN addgroup --gid 1000 xmrig \
    && adduser --uid 1000 -H -D -G xmrig -h /bin/xmrig xmrig
COPY --from=builder --chown=xmrig:xmrig [ "/xmrig/build/xmrig", "/bin/xmrig" ]
USER xmrig
ENTRYPOINT ["/bin/xmrig"]
CMD ["--help"]
