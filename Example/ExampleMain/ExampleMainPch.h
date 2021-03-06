//----------------------------------------------------------------------------------------------------------------------
// ExampleMainPch.h
//
// Copyright (C) 2010 WhiteMoon Dreams, Inc.
// All Rights Reserved
//----------------------------------------------------------------------------------------------------------------------

#pragma once
#ifndef EXAMPLE_EXAMPLE_MAIN_PCH_H
#define EXAMPLE_EXAMPLE_MAIN_PCH_H

#include "Platform/Trace.h"
#include "Framework/GameSystem.h"
#include "Framework/MemoryHeapPreInitialization.h"
#include "Framework/NullRendererInitialization.h"
#include "FrameworkWin/CommandLineInitializationWin.h"
#include "FrameworkWin/ObjectTypeRegistrationWin.h"
#include "FrameworkWin/ObjectLoaderInitializationWin.h"
#include "FrameworkWin/ConfigInitializationWin.h"
#include "FrameworkWin/WindowManagerInitializationWin.h"
#include "FrameworkWin/RendererInitializationWin.h"
#include "Foundation/File/Path.h"
#include "Foundation/File/File.h"
#include "Engine/CacheManager.h"

#include <tchar.h>

#endif  // EXAMPLE_EXAMPLE_MAIN_PCH_H
