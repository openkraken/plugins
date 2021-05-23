/*
 * Copyright (C) 2020 Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */

#include "video_element.h"

namespace kraken::binding::jsc {

std::unordered_map<JSContext *, JSVideoElement *> JSVideoElement::instanceMap{};

JSVideoElement::~JSVideoElement() {
  instanceMap.erase(context);
}

JSVideoElement::JSVideoElement(JSContext *context) : JSMediaElement(context) {}

JSObjectRef JSVideoElement::instanceConstructor(JSContextRef ctx, JSObjectRef constructor, size_t argumentCount,
                                                const JSValueRef *arguments, JSValueRef *exception) {
  auto instance = new VideoElementInstance(this);
  return instance->object;
}

JSVideoElement::VideoElementInstance::VideoElementInstance(JSVideoElement *JSVideoElement)
  : MediaElementInstance(JSVideoElement, "video"), nativeVideoElement(new NativeVideoElement(nativeMediaElement)) {
  std::string tagName = "video";
  NativeString args_01{};
  buildUICommandArgs(tagName, args_01);

  foundation::UICommandBuffer::instance(context->getContextId())
    ->addCommand(eventTargetId, UICommand::createElement, args_01, nativeVideoElement);
}

JSVideoElement::VideoElementInstance::~VideoElementInstance() {
  ::foundation::UICommandCallbackQueue::instance()->registerCallback([](void *ptr) {
    delete reinterpret_cast<NativeVideoElement *>(ptr);
  }, nativeVideoElement);
}

} // namespace kraken::binding::jsc

void initBridge() {
  using namespace kraken::binding::jsc;
  JSElement::defineElement("video", [](JSContext *context) -> ElementInstance * {
    return new JSVideoElement::VideoElementInstance(JSVideoElement::instance(context));
  });
}
