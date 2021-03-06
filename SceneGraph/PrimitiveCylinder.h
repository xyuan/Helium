#pragma once

#include "PrimitiveRadius.h"

namespace Helium
{
    namespace SceneGraph
    {
        class PrimitiveCylinder : public PrimitiveRadius
        {
        public:
            typedef PrimitiveRadius Base;

            float m_Length;
            int m_LengthSteps;

            bool m_VerticalOrientation;

        public:
            PrimitiveCylinder();

            int GetWireVertCount() const;
            int GetPolyVertCount() const;

            virtual void Update() HELIUM_OVERRIDE;
            virtual void Draw(
                Helium::BufferedDrawer* drawInterface, DrawArgs* args, Helium::Color materialColor = Color::WHITE,
                const Simd::Matrix44& transform = Simd::Matrix44::IDENTITY, const bool* solid = NULL,
                const bool* transparent = NULL ) const HELIUM_OVERRIDE;
            virtual bool Pick( PickVisitor* pick, const bool* solid = NULL ) const HELIUM_OVERRIDE;
        };
    }
}