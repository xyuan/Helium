#include "AudioClip.h"

using namespace Helium;
using namespace Helium::Asset;

REFLECT_DEFINE_ENUMERATION( AudioClipMode );
REFLECT_DEFINE_CLASS( AudioClip );

void AudioClip::AcceptCompositeVisitor( Reflect::Composite& comp )
{
    comp.SetProperty( AssetProperties::FileFilter, "*.wav;*.mp3;*.ogg" );

    comp.AddEnumerationField( &AudioClip::m_Mode, "m_Mode" );
}

void AudioClip::GatherSearchableProperties( Helium::SearchableProperties* properties ) const
{
    const Reflect::Enumeration* modeEnum = Reflect::GetEnumeration< AudioClipMode >();
    if ( modeEnum )
    {
        tstring mode;
        if ( modeEnum->GetElementLabel( (uint32_t)m_Mode, mode ) )
        {
            properties->Insert( *modeEnum->m_Name, mode );
        }
    }

    __super::GatherSearchableProperties( properties );
}